-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.nestedFock_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_spectralFamily_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in

theorem solution {ι₀ : Type*} {lam : κ → ℝ}
    {v : κ → Idx ι₀ → ℂ} (hv : ∀ k, Summable fun p => ‖v k p‖)
    (hlam : Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx (Idx ι₀)))
      ((exchangeH (ω := fun _ : Idx ι₀ => (0 : ℝ)) (fun _ => le_rfl)
          (fun z : κ × Idx ι₀ × Idx ι₀ => z.2.1) (fun z => z.2.2) (specAmp lam v)
          (summable_specAmp hv hlam)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig (fun _ : Idx ι₀ => (0 : ℝ)))))) :=
  spectralFamily_essentiallySelfAdjointOn_core hv hlam

end
