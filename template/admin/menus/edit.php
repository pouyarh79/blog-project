<?php

require_once(BASE_PATH . '/template/admin/layouts/header.php');

?>
<section class="pt-3 pb-1 mb-2 border-bottom">
    <h1 class="h5">Edit Menu</h1>
</section>

<section class="row my-3">
    <section class="col-12">
        <form method="post" action="<?= url('admin/menu/update/' . $menu['id']) ?>">

            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<?= $menu['name'] ?>" required>
            </div>

            <div class="form-group">
                <label for="url">url</label>
                <input type="text" class="form-control" id="url" name="url" value="<?= $menu['url'] ?>" required>
            </div>

            <div class="form-group">
                <label for="parent_id">parent ID</label>
                <select name="parent_id" id="parent_id" class="form-control" autofocus>

                    <option value="" <?php if($menu['parent_id'] == '' ) echo 'selected'?>>root</option>

                    <?php foreach($menus as $selectedMenu) {?>
                        <?php if($menu['id'] != $selectedMenu['id']) {?>
                    <option value="<?= $selectedMenu['id']?>" <?php if($menu['parent_id'] == $selectedMenu['id']) echo 'selected' ?>>
                         <?= $selectedMenu['name']?>
                    </option>
                    <?php } } ?>
                </select>
            </div>

            <button type="submit" class="btn btn-primary btn-sm">update</button>
        </form>
    </section>
</section>
<?php

require_once(BASE_PATH . '/template/admin/layouts/footer.php');
?>