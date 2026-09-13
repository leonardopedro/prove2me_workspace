-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.fibreHam_abelian_esa
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
open BookProof.YangMillsGhost















noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ω : Fin K → ℝ) (S : GConf K) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (fibreHam 0 ω S) :=
  essentiallySelfAdjointOn_add_bounded _ (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
      ymAbelian_essentiallySelfAdjointOn_core
      (((ghostEnergy ω S : ℝ) : ℂ) • ContinuousLinearMap.id ℂ (L2d 99))
      (fun u v => by
        simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
          inner_smul_left, inner_smul_right, Complex.conj_ofReal])
