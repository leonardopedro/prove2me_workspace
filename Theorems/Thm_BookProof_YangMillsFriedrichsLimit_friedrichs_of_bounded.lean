-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.friedrichs_of_bounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.friedrichs_of_bounded [CompleteSpace F] {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (C : ℝ) (hbd : ∀ x : D, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) := by
  -- the continuous extension
  have hb : ∀ x : D, ‖H x‖ ≤ C * ‖x‖ := fun x => by simpa using hbd x
  set Hc : D →L[ℂ] F := H.mkContinuous C hb with hHc
  have hdr : DenseRange (D.subtypeL) := by
    simpa [DenseRange, Submodule.subtypeL, Set.range_comp] using hdense
  have hui : IsUniformInducing (D.subtypeL) :=
    (isometry_subtype_coe (s := (D : Set F))).isUnifo := by sorry
