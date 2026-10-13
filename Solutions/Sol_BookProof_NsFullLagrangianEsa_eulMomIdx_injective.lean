-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.eulMomIdx_injective
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterEsaClosureCore
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective NsFullEuler.momIdx := by

  intro s t h
  have hv := congrArg Fin.val h
  have hs := s.isLt
  have ht := t.isLt
  apply Fin.ext
  simp only [NsFullEuler.momIdx, NsFullEuler.uIdx, NsFullEuler.dIdx] at hv
  split_ifs at hv <;> simp only at hv <;> omega
