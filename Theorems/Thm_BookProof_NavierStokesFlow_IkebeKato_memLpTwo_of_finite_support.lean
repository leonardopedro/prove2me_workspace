-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_finite_support
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine


theorem BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_finite_support {g : ι → ℂ} (h : (Function.support g).Finite) :
    Memℓp g 2 := by sorry
