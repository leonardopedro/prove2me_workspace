-- Generated from ChapterNsScalarFourier.lean — theorem BookProof.NsScalarFourier.nsScalarFourier_apply
import Mathlib
import Definitions.Def_ChapterNsScalarFourier
import Definitions.Def_ChapterNsPartialFourier
import Definitions.Def_ChapterA4
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]
variable (V W) in


open MeasureTheory



noncomputable section


theorem BookProof.NsScalarFourier.nsScalarFourier_apply (g : Lp ℂ 2 ((volume : Measure V).prod (volume : Measure W))) :
    nsScalarFourier V W g = curryLI (nsPartialFourier V W (curryLI.symm g)) := by sorry
