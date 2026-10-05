-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.cAnnS_eq_cAnnFin
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.cAnnS_eq_cAnnFin {f : Ell2} {J : Finset ℕ} (h : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J) :
    cAnnS f = cAnnFin J (fun i => f i) := by sorry
