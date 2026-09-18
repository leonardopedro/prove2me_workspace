import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.wave_add_smoothTruncatedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_StrichartzWave_exists_smooth_cutoff
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ)
    (W : SpaceTime n → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (R : ℝ) :
    ∃ WR : SpaceTime n → ℝ, Function.HasTemperateGrowth WR ∧
      (∀ x, ‖x‖ ≤ R → WR x = W x) ∧ (∀ x, R + 1 ≤ ‖x‖ → WR x = 0) ∧
      EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
        (opL2 (waveOp n 0 + potentialOp WR)) := by

  obtain ⟨χ, hχsmooth, hχc, hχone, -, hχzero, -⟩ := exists_smooth_cutoff (V := SpaceTime n) R
  have hcs : HasCompactSupport (fun x => W x * χ x) := hχc.mul_left
  have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun x => W x * χ x) := hW.mul hχsmooth
  refine ⟨fun x => W x * χ x, hcs.hasTemperateGrowth hsmooth, ?_, ?_, ?_⟩
  · intro x hx
    change W x * χ x = W x
    rw [hχone x hx, mul_one]
  · intro x hx
    change W x * χ x = 0
    rw [hχzero x hx, mul_zero]
  · exact wave_add_boundedPotentialOp_essentiallySelfAdjoint n _
      (hcs.hasTemperateGrowth hsmooth)
      (memLp_top_of_continuous_of_hasCompactSupport
        (hW.continuous.mul hχsmooth.continuous) hcs)
