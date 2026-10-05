-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.schur_test
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.schur_test {L : Finset ℕ} {m : ℕ → ℕ → ℝ} {x y : ℕ → ℝ} {K : ℝ}
    (hm : ∀ k j, 0 ≤ m k j) (hx : ∀ k, 0 ≤ x k) (hy : ∀ j, 0 ≤ y j) (hK0 : 0 ≤ K)
    (hrow : ∀ k, ∑ j ∈ L, m k j ≤ K) (hcol : ∀ j, ∑ k ∈ L, m k j ≤ K) :
    ∑ k ∈ L, ∑ j ∈ L, m k j * (x k * y j)
      ≤ K * (Real.sqrt (∑ k ∈ L, x k ^ 2) * Real.sqrt (∑ j ∈ L, y j ^ 2)) := by sorry
