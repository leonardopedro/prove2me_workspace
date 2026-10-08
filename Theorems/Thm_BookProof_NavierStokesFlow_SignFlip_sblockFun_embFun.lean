-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.sblockFun_embFun
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

theorem BookProof.NavierStokesFlow.SignFlip.sblockFun_embFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (j : J) (a : ℕ → ℂ) :
    sblockFun κ c hκ (embFun j a)
      = embFun j (fun n => (affData (hκ j) (abs_nonneg (c j))).fst.hFun a n
          + esgn (c j) * (affData (hκ j) (abs_nonneg (c j))).snd.hFun a n) := by sorry
