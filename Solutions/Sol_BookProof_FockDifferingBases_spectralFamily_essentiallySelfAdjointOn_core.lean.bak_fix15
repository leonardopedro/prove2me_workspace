-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.spectralFamily_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_exchangeH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FockDifferingBases_summable_specAmp
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {lam : κ → ℝ} {v : κ → ι → ℂ}
    (hv : ∀ k, Summable fun p => ‖v k p‖)
    (hlam : Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH (ω := exchangeH_essentiallySelfAdjointOn_core _ _ _ _ _ (fun _ => rfl)
