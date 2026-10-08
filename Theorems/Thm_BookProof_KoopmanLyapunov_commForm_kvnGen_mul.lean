-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.commForm_kvnGen_mul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.KoopmanLyapunov



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}


theorem BookProof.KoopmanLyapunov.commForm_kvnGen_mul {G : Fin d → MvPolynomial (Fin d) ℂ} (hG : ∀ i, RealCoeff (G i))
    {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) (x : polyGaussCore (d := d)) :
    commForm (kvnGenOp G) (mulCoreOp E) x
      = (gpair ((coreRepPoly d).equiv.symm x)
          ((∑ i, G i * pderiv i E) * (coreRepPoly d).equiv.symm x)).re := by sorry
