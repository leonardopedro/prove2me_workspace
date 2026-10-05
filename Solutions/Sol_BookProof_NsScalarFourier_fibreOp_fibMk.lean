-- Generated from ChapterNsScalarFourier.lean — solution of BookProof.NsScalarFourier.fibreOp_fibMk
import Mathlib
import Definitions.Def_ChapterNsScalarFourier
open BookProof.NsScalarFourier



open MeasureTheory


open BookProof.NsPartialFourier BookProof.NsScalarVectorCurry

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]
variable (V W) in
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution (T : Lp ℂ 2 (volume : Measure W) →L[ℂ] Lp ℂ 2 (volume : Measure W))
    (a : Lp ℂ 2 (volume : Measure V)) (c : Lp ℂ 2 (volume : Measure W)) :
    fibreOp V T (fibMk a c) = fibMk a (T c) := by

  refine Lp.ext ?_
  filter_upwards [T.coeFn_compLp (fibMk a c), coeFn_fibMk a c, coeFn_fibMk a (T c)]
    with x h1 h2 h3
  rw [fibreOp_apply, h1, h2, h3, map_smul]
