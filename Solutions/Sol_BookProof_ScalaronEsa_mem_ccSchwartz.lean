-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.mem_ccSchwartz
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {f : 𝓢(E, ℂ)} :
    f ∈ ccSchwartz E ↔ HasCompactSupport (f : E → ℂ) := Iff.rfl
