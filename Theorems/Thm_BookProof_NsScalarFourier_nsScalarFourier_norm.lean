-- Generated from ChapterNsScalarFourier.lean — theorem BookProof.NsScalarFourier.nsScalarFourier_norm
import Definitions.Def_ChapterNsPartialFourier
import Definitions.Def_ChapterNsScalarVectorCurry
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

variable (V W) in

theorem BookProof.NsScalarFourier.nsScalarFourier_norm (g : Lp ℂ 2 ((volume : Measure V).prod (volume : Measure W))) :
    ‖nsScalarFourier V W g‖ = ‖g‖ := by sorry
