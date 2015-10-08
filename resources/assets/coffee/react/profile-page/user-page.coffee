###
# Copyright 2015 ppy Pty. Ltd.
#
# This file is part of osu!web. osu!web is distributed with the hope of
# attracting more community contributions to the core ecosystem of osu!.
#
# osu!web is free software: you can redistribute it and/or modify
# it under the terms of the Affero GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
###
el = React.createElement

class ProfilePage.UserPage extends React.Component
  editStart: (e) ->
    e.preventDefault()
    $.publish 'user:page:update', editing: true


  pageNew: =>
    canCreate = @props.withEdit and @props.user.isSupporter

    el 'div',
      className: 'profile-content flex-col-66 text-center'

      el 'button',
        className: 'profile-page-new-content btn-osu btn-osu--lite btn-osu--profile-page-edit'
        onClick: @editStart
        disabled: !canCreate
        Lang.get('users.show.page.edit_big')

      el 'p', className: 'profile-page-new-content profile-page-new-icon',
        el 'i', className: 'fa fa-pencil-square-o'

      el 'p',
        className: 'profile-page-new-content'
        dangerouslySetInnerHTML:
          __html: Lang.get('users.show.page.description')

      el 'p',
        className: 'profile-page-new-content'
        dangerouslySetInnerHTML:
          __html: Lang.get('users.show.page.restriction_info')


  pageShow: =>
    el 'div', className: 'profile-content flex-col-66',
      if @props.withEdit
        el 'div', className: 'profile-user-page-header',
          el 'a',
            className: 'post-viewer__action'
            href: '#'
            onClick: @editStart
            el 'i', className: 'fa fa-edit'

      el 'div', dangerouslySetInnerHTML:
        __html: @props.userPage.html

  render: =>
    if !@props.withEdit
      @pageShow()
    else if @props.userPage.editing
      el ProfilePage.UserPageEditor, userPage: @props.userPage
    else if @props.userPage.html == ''
      @pageNew()
    else
      @pageShow()