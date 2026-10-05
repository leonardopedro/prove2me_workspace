-- Generated from ChapterSmCarContinuum.lean — theorem BookProof.SmCarContinuum.inner_cAnn_left
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum



open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

theorem BookProof.SmCarContinuum.inner_cAnn_left (i : ℕ) (ψ φ : CFock) :
    (inner ℂ (cAnn i ψ) φ : ℂ) = inner ℂ ψ (cCre i φ) := by sorry
