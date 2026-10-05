-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.div3Vec_ne_zero
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 4) : div3Vec a (idxDE (spatial 0) (spatial 0) a) = 1 := by

  rw [div3Vec, Fin.sum_univ_three]
  have h1 : idxDE (spatial 0) (spatial 0) a ≠ idxDE (spatial 1) (spatial 1) a := by
    simp [idxDE, spatial, Fin.ext_iff]
  have h2 : idxDE (spatial 0) (spatial 0) a ≠ idxDE (spatial 2) (spatial 2) a := by
    simp [idxDE, spatial, Fin.ext_iff]
  simp [h1, h2]
