-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.brst_charge_nilpotent_fermiFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent
open BookProof.FermionFock

variable {ι : Type*} [DecidableEq ι]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

theorem BookProof.FermionFock.brst_charge_nilpotent_fermiFock {n : ℕ} (f : Fin n → Fin n → Fin n → ℝ)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    BookProof.BRSTNilpotent.Q f (ghostChi n) (ghostBeta n)
        * BookProof.BRSTNilpotent.Q f (ghostChi n) (ghostBeta n) = 0 := by sorry
