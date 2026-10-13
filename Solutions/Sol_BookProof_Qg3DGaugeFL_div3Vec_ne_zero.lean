-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.div3Vec_ne_zero
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.QuantumGravity3DGauge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 4) : div3Vec a (idxDE (spatial 0) (spatial 0) a) = 1 := by

  rw [div3Vec, Fin.sum_univ_three]
  have h1 : idxDE (spatial 0) (spatial 0) a ≠ idxDE (spatial 1) (spatial 1) a := by
    simp [idxDE, spatial, Fin.ext_iff]
  have h2 : idxDE (spatial 0) (spatial 0) a ≠ idxDE (spatial 2) (spatial 2) a := by
    simp [idxDE, spatial, Fin.ext_iff]
  simp [h1, h2]
