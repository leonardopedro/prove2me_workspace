-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.mulRep_toLp
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution (g f : C(spectrum ℂ T, ℂ)) :
    mulRep (spectralMeasure T hT xi) g
        (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f)
      = ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ (g * f) := by

  set mu := spectralMeasure T hT xi with hmu
  refine Lp.ext ?_
  filter_upwards [mulRep_coeFn mu g (ContinuousMap.toLp 2 mu ℂ f),
    ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) f,
    ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) (g * f)] with z h1 h2 h3
  rw [h1, h2, h3]
  simp
