-- Generated from ChapterNsFieldMomentumInverse.lean — theorem BookProof.NsFieldMomentumInverse.cut_mem_momDomain
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
open BookProof.NsFieldMomentumInverse

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]



open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section


theorem BookProof.NsFieldMomentumInverse.cut_mem_momDomain {m : W} (hm : m ≠ 0) (n : ℕ) (f : Lp ℂ 2 (volume : Measure W)) :
    cut m n f ∈ momDomain m := by sorry
