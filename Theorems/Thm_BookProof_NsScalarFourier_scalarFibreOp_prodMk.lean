-- Generated from ChapterNsScalarFourier.lean — theorem BookProof.NsScalarFourier.scalarFibreOp_prodMk
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
variable (V) in


open MeasureTheory



noncomputable section


theorem BookProof.NsScalarFourier.scalarFibreOp_prodMk (T : Lp ℂ 2 (volume : Measure W) →L[ℂ] Lp ℂ 2 (volume : Measure W))
    (a : Lp ℂ 2 (volume : Measure V)) (c : Lp ℂ 2 (volume : Measure W)) :
    scalarFibreOp V T (prodMk a c) = prodMk a (T c) := by sorry
