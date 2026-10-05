-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.spectralUnitary_intertwines_cfc
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_mulRep_toLp
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution (g : C(spectrum ℂ T, ℂ))
    (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) g u)
      = cfcHom hT g (spectralUnitary T hT xi hcyc u) := by

  have hdense : DenseRange
      ((ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ).toLinearMap :
        C(spectrum ℂ T, ℂ) → Lp ℂ 2 (spectralMeasure T hT xi)) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := spectralMeasure T hT xi) (by simp)
  have hcont₁ : Continuous fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
      spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) g v) :=
    (spectralUnitary T hT xi hcyc).continuous.comp
      (mulRep (spectralMeasure T hT xi) g).continuous
  have hcont₂ : Continuous fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
      cfcHom hT g (spectralUnitary T hT xi hcyc v) :=
    (cfcHom hT g).continuous.comp (spectralUnitary T hT xi hcyc).continuous
  have hfun : (fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
        spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) g v))
      = fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
        cfcHom hT g (spectralUnitary T hT xi hcyc v) := by
    refine hdense.equalizer hcont₁ hcont₂ (funext fun f => ?_)
    simp only [Function.comp_apply, ContinuousLinearMap.coe_coe]
    rw [mulRep_toLp T hT xi g f, spectralUnitary_toLp, spectralUnitary_toLp, map_mul]
    rfl
  exact congrFun hfun u
