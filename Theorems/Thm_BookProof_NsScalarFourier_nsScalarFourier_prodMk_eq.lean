-- Generated from ChapterNsScalarFourier.lean — theorem BookProof.NsScalarFourier.nsScalarFourier_prodMk_eq
import Definitions.Def_ChapterNsScalarVectorCurry
import Mathlib
import Definitions.Def_ChapterNsScalarFourier
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier
open BookProof.NsScalarFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]
variable (V W) in
variable (V) in


open MeasureTheory


open BookProof.NsPartialFourier BookProof.NsScalarVectorCurry

noncomputable section


theorem BookProof.NsScalarFourier.nsScalarFourier_prodMk_eq (a : Lp ℂ 2 (volume : Measure V))
    (c : Lp ℂ 2 (volume : Measure W)) :
    nsScalarFourier V W (prodMk a c) = curryLI (nsPartialFourier V W (fibMk a c)) := by sorry
