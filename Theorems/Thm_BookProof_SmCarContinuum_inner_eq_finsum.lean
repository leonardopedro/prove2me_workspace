-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.inner_eq_finsum
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

theorem BookProof.SmCarContinuum.inner_eq_finsum {f g : Ell2} {J : Finset ℕ} (hf : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J) :
    (inner ℂ f g : ℂ) = ∑ i ∈ J, (starRingEnd ℂ) ((f : ℕ → ℂ) i) * (g : ℕ → ℂ) i := by sorry
