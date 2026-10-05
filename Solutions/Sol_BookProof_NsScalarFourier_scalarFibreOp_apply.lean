-- Generated from ChapterNsScalarFourier.lean — solution of BookProof.NsScalarFourier.scalarFibreOp_apply
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
    (g : Lp ℂ 2 ((volume : Measure V).prod (volume : Measure W))) :
    scalarFibreOp V T g = curryLI (fibreOp V T (curryLI.symm g)) := rfl
