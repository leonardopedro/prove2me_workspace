-- Generated from ChapterParityMajoranaQuant.lean — solution of BookProof.ChapterParityMajoranaQuant.annihProj_herm
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
import Theorems.Thm_BookProof_ChapterParityMajoranaQuant_iJ_herm
open BookProof.ChapterParityMajoranaQuant











open Matrix
open scoped ComplexConjugate


variable {m : ℕ}




variable (J : Matrix (Fin m) (Fin m) ℂ)

set_option maxHeartbeats 1000000 in
theorem solution (hskew : Jᴴ = -J) : (annihProj J)ᴴ = annihProj J := by

  unfold annihProj
  rw [conjTranspose_smul, conjTranspose_add, conjTranspose_one, iJ_herm J hskew,
    Complex.star_def, map_div₀, map_one, Complex.conj_ofNat]
