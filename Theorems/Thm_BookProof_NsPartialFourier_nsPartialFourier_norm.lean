-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.nsPartialFourier_norm
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable (V F) in
variable (V) in
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]
variable (V W) in



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.nsPartialFourier_norm (v : Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) :
    ‖nsPartialFourier V W v‖ = ‖v‖ := by sorry
