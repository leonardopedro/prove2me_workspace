import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# orientation of the diagonal sign gauge

This file refines the orthogonal matrix representation of the diagonal Born sign
gauge by separating its orientation-preserving and orientation-reversing parts.
The determinant character computed in `ChapterFreeFieldBornSignMatrix` is `+1`
exactly when an even number of coordinates are flipped and is `-1` exactly when
an odd number are flipped.  Consequently the even-weight sign choices are
precisely the matrices in the special orthogonal group.

## Main results

* `flipMatrix_transpose` — every sign matrix is symmetric.
* `flipMatrix_mem_orthogonalGroup` — every sign matrix belongs to `O(n)`.
* `det_flipMatrix_eq_one_iff` — determinant `+1` iff the flip count is even.
* `det_flipMatrix_eq_neg_one_iff` — determinant `-1` iff the flip count is odd.
* `flipMatrix_mem_specialOrthogonalGroup_iff` — membership in `SO(n)` iff the
  flip count is even.
-/
namespace BookProof.ChapterFreeFieldBornSignOrientation

end BookProof.ChapterFreeFieldBornSignOrientation
