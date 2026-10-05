-- Generated from ChapterNsScalarFourier.lean — solution of BookProof.NsScalarFourier.nsScalarFourier_prodMk_eq
import Mathlib
import Definitions.Def_ChapterNsScalarFourier
import Theorems.Thm_BookProof_NsScalarFourier_nsScalarFourier_apply
import Theorems.Thm_BookProof_NsScalarVectorCurry_curryLI_fibMk
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
theorem solution (a : Lp ℂ 2 (volume : Measure V))
    (c : Lp ℂ 2 (volume : Measure W)) :
    nsScalarFourier V W (prodMk a c) = curryLI (nsPartialFourier V W (fibMk a c)) := by

  rw [nsScalarFourier_apply,
    ← curryLI_fibMk (μ := (volume : Measure V)) (ν := (volume : Measure W)),
    LinearIsometryEquiv.symm_apply_apply]
