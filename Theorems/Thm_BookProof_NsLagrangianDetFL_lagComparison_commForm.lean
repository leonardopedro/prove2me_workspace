-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.lagComparison_commForm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.NsLagrangianDetFL

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section


theorem BookProof.NsLagrangianDetFL.lagComparison_commForm (x : polyGaussCore (d := lagDim K)) :
    commForm (lagKoopmanOp S) (lagComparison S) x
      = (gpair ((coreRepPoly (lagDim K)).equiv.symm x)
          (rename lagEquiv (lagFlux S) * (coreRepPoly (lagDim K)).equiv.symm x)).re := by sorry
