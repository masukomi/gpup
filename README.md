# A safer, and easier git push

## G.P.U.P - Git Push to Upstream (branch)
(alternately Git Push UP)

`git push --force` is a common task when updating a topic branch
you've already pushed to GitHub (or any other remote server), but 
if your git is misconfigured, or you simply have a brain-fart and 
type the wrong thing you can destroy (or mutilate) public history,
which screws everyone else who's working on the project. 

Bad force pushes can happen when someone accidentally types in 
the wrong branch name, the wrong repo name, OR types neither but 
has a misconfigured git repo.


`gpup` solves that problem. It's a bash function (should work in zsh too)
that does the right thing. Assuming you're following the standard workflow
of *only doing work on topic branches*, and only ever pushing with force 
to those topic branches. 

How does it work. Simple, it gives you a better and easier habit, and 
doesn't assume your git repo is configured correctly.

The next time you need to do a `git push` or `git push -f` just type
`gpup` (or `gpup -f`) instead. You don't need to follow that with anything.
It'll do the right thing (see Usage).

## Installation.
Assuming you use bash then just clone this repo and add 
`source /path/to/gpup/gpup.sh` to your `~/.bashrc` or `~/.bash_profile`
and it will be available the next time you launch a terminal or 
source that file. 

## Usage
When pushing a new topic branch for the first time it will want to set up
the upstream tracking branch. If you don't know what this means, or 
want the default behavior, just hit enter. If you do then you 
can still just hit enter, or type `n` and configure your upstream in 
whatever whacky way you fancy.

From then on gpup will always push to the specified upstream branch.


## Warning

`gpup` will **only** push to the `origin` repository. 
This is by design. You can still use `git push` and its full
range of capabilities if you need to do something atypical. 

If you checked out an existing a branch from a remote repo this
will probably be configured already by git to have your local branch
tracking the remote repo. **gpup will change this configuration**. 
It will change the remote repo to be 'origin' so that you never 
accidentally push with force to that remote. 

This is because your default behavior should be to only push to your 
repository. Mucking with someone else's repo should be an atypical 
operation, and thus you can use the default `git push` to do that.


## Historical note

Once upon a time gpup would push to whatever tracking branch 
was set up. This enabled less sophisticated users to accidentally
push to someone else's remote repo. The goal of gpup is to remove
the ability to accidentally push to the wrong repo. 

## But couldn't I just...
Yes, you *can* just configure your git repo to prevent you from 
*ever* pushing to a specific repo. 

    git remote set-url --push upstream you_really_shouldnt_push_to_upstream

...but that doesn't prevent you from accidentally pushing to the wrong 
branch because you had a brain fart while your fingers were typing and 
typed the wrong branch name. gpup gives you a safer and easier habit.


