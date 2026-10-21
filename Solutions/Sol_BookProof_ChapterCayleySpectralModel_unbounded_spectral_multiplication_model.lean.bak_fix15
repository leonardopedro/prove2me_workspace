-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.unbounded_spectral_multiplication_model
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_isStarNormal_cayleyCLM
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_spectralUnitary_resSymbol
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_spectralUnitary_opSymbol
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_isProbabilityMeasure_spectralMeasure
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
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
variable (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1)
    (hcyc : DenseRange (cfcVec (cayleyCLM T) (isStarNormal_cayleyCLM T) xi)) :
    ∃ (mu : Measure (spectrum ℂ (cayleyCLM T))) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ u : Lp ℂ 2 mu, ∃ hmem : U (mulRep mu (resSymbol T) u) ∈ T.domain,
        T.op ⟨U (mulRep mu (resSymbol T) u), hmem⟩ = U (mulRep mu (opSymbol T) u)) ∧
      (∀ x : T.domain, ∃ u : Lp ℂ 2 mu, U (mulRep mu (resSymbol T) u) = (x : H)) := by

  refine ⟨spectralMeasure (cayleyCLM T) (isStarNormal_cayleyCLM T) xi,
    isProbabilityMeasure_spectralMeasure (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hxi,
    spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc, ?_, ?_⟩
  · intro u
    have hres := spectralUnitary_resSymbol T xi hcyc u
    refine ⟨by rw [hres]; exact (T.res (-1) _).2, ?_⟩
    have hsub : (⟨spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc
        (mulRep (spectralMeasure (cayleyCLM T) (isStarNormal_cayleyCLM T) xi) (resSymbol T) u),
        by rw [hres]; exact (T.res (-1) _).2⟩ : T.domain)
        = T.res (-1) (spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc u) :=
      Subtype.ext hres
    rw [hsub, spectralUnitary_opSymbol]
  · intro x
    refine ⟨(spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc).symm
      (T.shift (-1) x), ?_⟩
    rw [spectralUnitary_resSymbol, LinearIsometryEquiv.apply_symm_apply,
      T.res_shift (by norm_num) x]
