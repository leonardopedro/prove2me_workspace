-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.brst_charge_nilpotent_fermiFock
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_ghostCAR_creF_annF
import Theorems.Thm_BookProof_BRSTNilpotent_brst_charge_nilpotent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)
open BookProof.BRSTNilpotent

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (f : Fin n → Fin n → Fin n → ℝ)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    BookProof.BRSTNilpotent.Q f (ghostChi n) (ghostBeta n)
        * BookProof.BRSTNilpotent.Q f (ghostChi n) (ghostBeta n) = 0 := BookProof.BRSTNilpotent.brst_charge_nilpotent f _ _ (ghostCAR_creF_annF n) hf12 hjac
