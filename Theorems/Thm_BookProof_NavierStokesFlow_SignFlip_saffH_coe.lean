-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.saffH_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData
open BookProof.NavierStokesFlow.SignFlip

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

theorem BookProof.NavierStokesFlow.SignFlip.saffH_coe {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) (x : maxDom (oscSymbol (affMu κ |c|)))
    (β : ℕ) :
    ((saffH hκ c x : L2I ℕ) : ℕ → ℂ) β
      = (affData hκ (abs_nonneg c)).fst.hFun ((x : L2I ℕ) : ℕ → ℂ) β
        + esgn c * (affData hκ (abs_nonneg c)).snd.hFun ((x : L2I ℕ) : ℕ → ℂ) β := by sorry
