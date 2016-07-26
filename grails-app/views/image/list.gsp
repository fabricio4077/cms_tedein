<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <ig:resources/>
  <title>image</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
  <span class="menuButton"><g:link class="create" action="create">New</g:link></span>
</div>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<div class="list">

    <g:each in="${images}" status="i" var="image">
      <ig:img src="${createLink(action: 'showImage', controller: 'image', id: image?.id)}" alt="${image?.caption}" title="${image?.caption}"
              thumbnailSrc="${createLink(action: 'showImage', controller: 'image', id: image?.id,params:[thumbnail:true])}"/>
    </g:each>
 
</div>
<div class="paginateButtons">
  <g:paginate total="${imageTotal}"/>
</div>
</body>
</html>
