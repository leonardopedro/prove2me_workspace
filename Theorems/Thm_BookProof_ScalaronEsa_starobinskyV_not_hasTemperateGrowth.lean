-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.starobinskyV_not_hasTemperateGrowth
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.starobinskyV_not_hasTemperateGrowth {M alpha : ℝ} (hM : 0 < M) (halpha : 0 < alpha) :
    ¬ Function.HasTemperateGrowth (fun phi : ℝ => starobinskyV M alpha phi) := by sorry
