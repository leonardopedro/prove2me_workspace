-- Generated from ChapterOperatorSeriesEsa.lean — theorem BookProof.OperatorSeries.commForm_add
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.OperatorSeries

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat

noncomputable section

theorem BookProof.OperatorSeries.commForm_add (H₁ H₂ N : D →ₗ[ℂ] F) (x : D) :
    commForm (H₁ + H₂) N x = commForm H₁ N x + commForm H₂ N x := by sorry
