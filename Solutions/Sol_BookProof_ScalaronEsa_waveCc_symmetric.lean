-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.waveCc_symmetric
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_ScalaronEsa_symmetricOn_inclusion
import Theorems.Thm_BookProof_StrichartzWave_wave_symmetric
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : SymmetricOn (ccDomain (SpaceTime n)) (waveCc n) := symmetricOn_inclusion _ _ (wave_symmetric n 0)
