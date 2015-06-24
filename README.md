# A safer, and easier git push

## G.P.UP - Git Push UP

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
Whenever you would normally type `git push` type `gpup` instead. It will
pass on any aditional arguments to `git push` when it's done making sure
the push is going to the correct branch, and guaranteeing its going to 
the origin repo.

### Usage notes
`gpup` presumes you're following a standard GitHub workflow of forking 
some other repo, and having `origin` be *your* copy of that repo. A place
where you can muck things up as badly as you want without harming others.

It doesn't hurt to use it when `origin` is the main repo shared by others
but it isn't going to provide nearly the same level of additional safety.


When pushing a new topic branch for the first time it will want to set up
the upstream tracking branch. If you don't know what this means, or 
want the default behavior, just hit enter. If you do then you 
can still just hit enter, or type `n` and configure your upstream in 
whatever whacky way you fancy.

From then on gpup will always push to the specified upstream branch. Because
it always uses the specified upstream branch this means you can still 
do more advanced things like having the branch you push to have a different
name than the local branch. Figuring out *how* to do that, or why
you would want to is your own problem to solve. ;)


## Warning

`gpup` will **only** push to the `origin` repository. 
This is by design. You can still use `git push` and its full
range of capabilities if you need to do something atypical. 

This is because your default behavior should be to only push to your 
repository. Mucking with someone else's repo should be an atypical 
operation, and thus you can use the default `git push` to do that.

`gpup` will leave the current tracking branch set to the remote, so 
that pulls will continue to pull from the remote repo. Normal 
`git push` operations (without gpup) will continue to push 
to the remote repo. 

To summarize. If you use gpup you're safe, but it doesn't
really muck with how things are configured. 

Technically it does a little but you shouldn't notice.

## Historical note

Once upon a time gpup would push to whatever tracking branch 
was set up. This left less sophisticated users able to accidentally
push to someone else's remote repo. The goal of gpup is to remove
the ability to accidentally push to any repo other than your own.

## But couldn't I just...
Yes, you *can* just configure your git repo to prevent you from 
*ever* pushing to a specific repo. 

    git remote set-url --push upstream you_really_shouldnt_push_to_upstream

...but that doesn't prevent you from accidentally pushing to the wrong 
branch because you had a brain fart while your fingers were typing and 
typed the wrong branch name. gpup gives you a safer and easier habit.


