-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGradedFock_not_bounded
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpDiag_not_bounded
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (omega g : ℕ → ℝ) (homega : omega = 0)
    (hg : ∀ C : ℝ, ∃ a, C < |g a|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes GradedIdx, ‖qgGradedHam omega g f‖ ≤ C * ‖f‖ := by

  refine lpDiag_not_bounded _ fun C => ?_
  obtain ⟨a, ha⟩ := hg C
  refine ⟨(0, ({a} : FermConf)), ?_⟩
  rwa [show qgGradedSymbol omega g (0, ({a} : FermConf)) = g a by
    simp [qgGradedSymbol, homega, BookProof.NavierStokesFlow.FockOfFock.confEnergy, ghostEnergy]]
