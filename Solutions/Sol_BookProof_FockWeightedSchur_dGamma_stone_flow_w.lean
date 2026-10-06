-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.dGamma_stone_flow_w
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_dGamma_essentiallySelfAdjointOn_core_w
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    (hBg : WCommBound w col B) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp col) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ finiteOccupation_dense (dGammaOp_symmetricOn hherm)
      (dGamma_essentiallySelfAdjointOn_core_w hw hherm hrow hcolg hK0 hBg)
