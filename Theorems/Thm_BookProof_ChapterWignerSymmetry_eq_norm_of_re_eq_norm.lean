-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.eq_norm_of_re_eq_norm
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.eq_norm_of_re_eq_norm {z : ℂ} (h : z.re = ‖z‖) : z = (‖z‖ : ℂ) := by sorry
