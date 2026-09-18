-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.wave_add_scalaronTruncated_esa
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

import Definitions.Def_BookProof.ChapterScalaronEsa

open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.wave_add_scalaronTruncated_esa (n : ℕ) (M alpha : ℝ) (e : SpaceTime n) (R : ℝ) :
    ∃ WR : SpaceTime n → ℝ, Function.HasTemperateGrowth WR ∧
      (∀ x, ‖x‖ ≤ R → WR x = starobinskyV M alpha (inner ℝ x e)) ∧
      (∀ x, R + 1 ≤ ‖x‖ → WR x = 0) ∧
      EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
        (opL2 (waveOp n 0 + potentialOp WR)) := by sorry
