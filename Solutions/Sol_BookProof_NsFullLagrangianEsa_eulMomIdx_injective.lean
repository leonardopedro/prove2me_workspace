-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.eulMomIdx_injective
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
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
