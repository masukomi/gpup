# Public: Git Push to UPstream (branch)
#         Setting a tracking branch only affects git pull.
#         This will perform a git push to wherever git pull
#         would come from, or just do "git pull" (at your command).
#
#         Most people don't encounter the problem because it'll
#         default to pushing to a repo of the same name as your
#         local one on origin, which is how most people's branches
#         are configured. If your local name differs from the corresponding
#         branch on origin, or you are tracking a separate repo,
#         subtle problems can creep in if you're not paying attention.
#
#         So, always use gpup and you won't have issues.
#
# args - any arguments you pass to gpup will be passed on to git push
#
# TODO: test incoming args for -f or --force and replace with --force-with-lease
function gpup {
	CURRENT_GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	REMOTE=$(git config --get "branch.$CURRENT_GIT_BRANCH.remote")
	if [ "$REMOTE" != "" ]; then
		MERGE=$(git config --get "branch.$CURRENT_GIT_BRANCH.merge" | sed -e 's/.*\///g')
		if [ "$MERGE" != "" ]; then
			if [ $# -gt 0 ]; then
				echo "running: git push $@ $REMOTE $MERGE"
				git push $@ $REMOTE $MERGE
			else
				echo "running: git push $REMOTE $MERGE"
				git push $REMOTE $MERGE
			fi
		else
			echo "Umm... you've got a remote configured but not a merge. quitting"
		fi
	else
		echo "No branch specific upstream. "
		echo "Want me to set the upstream tracking to origin/$CURRENT_GIT_BRANCH ? [enter for yes|n]"
		read SET_UPSTREAM
		if [ "$SET_UPSTREAM" != "n" ]; then
			git push --set-upstream origin $CURRENT_GIT_BRANCH
		else
			echo "Ok, you'll probably want to run something like this soon:"
			echo "    git push --set-upstream origin $CURRENT_GIT_BRANCH"
		fi
		RESPOSNE='q'
		if [ "$SET_UPSTREAM" = "" ]; then
			RESPONSE=''
		else
			echo "Continue with default? [enter for yes|q for quit]"
			read RESPONSE
		fi
		if [ "$RESPONSE" = "" ]; then
			if [ $# -gt 0 ]; then
				echo "running: git push $@ origin $CURRENT_GIT_BRANCH"
				git push $@ $REMOTE $MERGE
			else
				echo "running: git push origin $CURRENT_GIT_BRANCH"
				git push origin $CURRENT_GIT_BRANCH
			fi
		else
			echo "quitting"
		fi
	fi
}


