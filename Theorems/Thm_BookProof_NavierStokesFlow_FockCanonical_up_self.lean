-- Generated from ChapterNavierStokesFockCanonical.lean — theorem BookProof.NavierStokesFlow.FockCanonical.up_self
import Mathlib
import Definitions.Def_ChapterNavierStokesFockCanonical
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockCanonical

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical


theorem BookProof.NavierStokesFlow.FockCanonical.up_self (i : Fin d) (α : Occ d) : up i α i = α i + 1 := by simp [up]

@[simp] theorem dn_self (i : Fin d) (α : Occ d) : dn i α i = α i - 1 := by simp [dn]

theorem up_injective (i : Fin d) : Function.Injective (up i : Occ d → Occ d) := by sorry
