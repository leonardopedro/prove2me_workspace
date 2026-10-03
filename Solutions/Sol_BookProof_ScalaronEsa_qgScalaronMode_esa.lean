-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.qgScalaronMode_esa
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgModeHamiltonian_essentiallySelfAdjoint
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]
variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc phi : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn := qgModeHamiltonian_essentiallySelfAdjoint a b (qgScalaronModePotential M alpha Rc phi)
