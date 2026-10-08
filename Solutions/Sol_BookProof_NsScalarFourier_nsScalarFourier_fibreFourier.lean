-- Generated from ChapterNsScalarFourier.lean — solution of BookProof.NsScalarFourier.nsScalarFourier_fibreFourier
import Mathlib
import Definitions.Def_ChapterNsScalarFourier
import Theorems.Thm_BookProof_NsScalarFourier_nsScalarFourier_scalarFibreOp
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
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution
    (g : Lp ℂ 2 ((volume : Measure V).prod (volume : Measure W))) :
    nsScalarFourier V W (scalarFibreOp V (fibreFourierCLM W) g)
      = scalarFibreOp V (fibreFourierCLM W) (nsScalarFourier V W g) := nsScalarFourier_scalarFibreOp _ g
