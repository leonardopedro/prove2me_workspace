-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.polarU_unique
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_polarIsom_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]
variable [CompleteSpace F] {D : Submodule ℂ F} (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
  (hsym : SymmetricOn D A)

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] F)
    (hV : ∀ x : clDom A, V (absOn A hdense hsym x) = clExt A hdense hsym x)
    (hV0 : ∀ z ∈ (initSpace (absOn A hdense hsym))ᗮ, V z = 0) : V = polarU A hdense hsym := polarIsom_unique _ _ _ V hV hV0
