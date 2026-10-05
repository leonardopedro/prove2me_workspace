-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.isStarNormal_cayleyCLM
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
open BookProof.ChapterCayleySpectralModel



open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution : IsStarNormal (cayleyCLM T) := by

  have hadj : star (cayleyCLM T) = ((cayley T).symm.toContinuousLinearEquiv : H →L[ℂ] H) := by
    symm
    rw [ContinuousLinearMap.star_eq_adjoint, ContinuousLinearMap.eq_adjoint_iff]
    intro x y
    change ⟪(cayley T).symm x, y⟫_ℂ = ⟪x, cayley T y⟫_ℂ
    rw [← (cayley T).inner_map_map ((cayley T).symm x) y,
      LinearIsometryEquiv.apply_symm_apply]
  constructor
  rw [hadj]
  ext x
  change (cayley T).symm (cayley T x) = cayley T ((cayley T).symm x)
  rw [LinearIsometryEquiv.apply_symm_apply, LinearIsometryEquiv.symm_apply_apply]
