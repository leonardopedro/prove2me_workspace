-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.nsSymbol_ge_one
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

theorem BookProof.NavierStokesFlow.MomentumEsa.nsSymbol_ge_one (d : ℕ) (p q : Fin d → ℕ → ℝ) (k : ℕ) : 1 ≤ nsSymbol d p q k := by sorry
