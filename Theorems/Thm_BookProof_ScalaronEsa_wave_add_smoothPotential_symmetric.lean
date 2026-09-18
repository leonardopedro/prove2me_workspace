-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.wave_add_smoothPotential_symmetric
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.wave_add_smoothPotential_symmetric (n : ℕ) (W : SpaceTime n → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    SymmetricOn (ccDomain (SpaceTime n)) (waveAddSmoothPotential n W hW) := by sorry
