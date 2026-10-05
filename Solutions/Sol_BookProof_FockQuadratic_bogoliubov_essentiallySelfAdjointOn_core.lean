-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.bogoliubov_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Theorems.Thm_BookProof_FockQuadratic_fockH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FockQuadratic_wsum_pairIdx
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable {ω : ι → ℝ}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (m n : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖ * (ω (m k) + ω (n k) + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω (fun k => pairIdx (m k) (n k)) (fun _ => (0 : Idx ι)) g
          (fun k => by simp)
          (by
            refine hsum.congr fun k => ?_
            simp [wsum_pairIdx])).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := fockH_essentiallySelfAdjointOn_core hω _ _ g _ _
