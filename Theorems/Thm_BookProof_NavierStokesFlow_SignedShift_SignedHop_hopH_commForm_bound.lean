-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift

variable {ι : Type*}
variable {sym : ι → ℝ} (S : SignedHop ι sym)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian AffineFiber


theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_commForm_bound (x : maxDom sym) :
    |commForm (hopH S) (diagMax sym) x|
      ≤ (2 * S.step * (1 / 4 + S.K)) * quadForm (diagMax sym) x := by sorry
