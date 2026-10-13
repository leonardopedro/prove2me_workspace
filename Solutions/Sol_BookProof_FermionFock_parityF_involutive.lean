-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.parityF_involutive
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FermiAlg) : parityF (parityF u) = u := by

  refine Finsupp.ext fun S => ?_
  rw [parityF_apply, parityF_apply, ← mul_assoc, ← pow_add, ← two_mul, pow_mul]
  norm_num
